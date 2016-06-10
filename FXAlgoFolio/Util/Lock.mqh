#ifndef FXALGOFOLIO_UTIL_LOCK
#define FXALGOFOLIO_UTIL_LOCK

void LockInit()
{
   // Set initial value.
   if (!GlobalVariableCheck("semaphore"))
   {
      GlobalVariableSet("semaphore", 0);
   }
   // Delete dead lock.
   else
   {
      double semaphore = GlobalVariableGet("semaphore");
      if (semaphore == 1 && GlobalVariableTime("semaphore") + 300 < TimeLocal())
      {
         LockRelease();
      }
   }
}

bool LockAcquire()
{
   // Short-circuit for strategy tester.
   if (IsTesting())
   {
      return true;
   }

   return GlobalVariableSetOnCondition("semaphore", 1, 0);
}

bool LockRelease()
{
   // Short-circuit for strategy tester.
   if (IsTesting())
   {
      return true;
   }

   return GlobalVariableSetOnCondition("semaphore", 0, 1);
}

#endif
