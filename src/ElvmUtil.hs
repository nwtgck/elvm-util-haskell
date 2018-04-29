{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE NamedFieldPuns #-}


module ElvmUtil where

import Data.Ix
import Data.Char
import Data.IORef
import Data.STRef
import Control.Monad.Catch
import Control.Monad.Trans
import Control.Monad.Trans.Identity
import Control.Monad.Trans.State
import Control.Monad.ST


class Monad m => GetPutInt m where
  getInt :: m Int
  putInt :: Int -> m ()

class Monad m => MRef m r where
  newRef    :: a -> m (r a)
  readRef   :: r a -> m a
  writeRef  :: r a -> a -> m ()
  modifyRef :: r a -> (a -> a) -> m ()

data InOut = InOut {input :: [Int], output :: [Int]} deriving (Show, Eq)

defaultInOut :: InOut
defaultInOut = InOut{input=[], output=[]}

instance GetPutInt IO where
  getInt =
    catch (do
        a <- fmap ord getChar
        return a
     )
     (\(SomeException e) -> return 0)
  putInt = putChar . chr

instance GetPutInt m => GetPutInt (IdentityT m) where
  getInt = lift getInt
  putInt = lift . putInt

instance Monad m => GetPutInt (StateT InOut m) where
  getInt = do
    xs <- gets input
    case xs of
      [] -> return 0
      x:xs -> do
       modify (\inOut -> inOut{input=xs})
       return x
  putInt i = do
    modify (\inOut@InOut{output} -> inOut{output=output ++ [i]})

instance MRef IO IORef where
  newRef = newIORef
  readRef = readIORef
  writeRef = writeIORef
  modifyRef = modifyIORef

instance MRef (ST s) (STRef s) where
  newRef = newSTRef
  readRef = readSTRef
  writeRef = writeSTRef
  modifyRef = modifySTRef

