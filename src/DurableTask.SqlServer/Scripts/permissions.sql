﻿-- Copyright (c) Microsoft Corporation.
-- Licensed under the MIT License.

-- Security 
IF DATABASE_PRINCIPAL_ID('dt_runtime') IS NULL
BEGIN
    -- This is the role to which all low-privilege user accounts should be associated using
    -- the 'ALTER ROLE dt_runtime ADD MEMBER [<username>]' statement.
    CREATE ROLE dt_runtime
END

-- Each stored procedure that is granted to dt_runtime must limits access to data based 
-- on the task hub since that is. that no
-- database user can access data created by another database user.

-- Functions 
GRANT EXECUTE ON OBJECT::dt.GetScaleMetric TO dt_runtime
GRANT EXECUTE ON OBJECT::dt.GetScaleRecommendation TO dt_runtime
GRANT EXECUTE ON OBJECT::dt.CurrentTaskHub TO dt_runtime

-- Public sprocs
GRANT EXECUTE ON OBJECT::dt.CreateInstance TO dt_runtime
GRANT EXECUTE ON OBJECT::dt.GetInstanceHistory TO dt_runtime
GRANT EXECUTE ON OBJECT::dt.QuerySingleOrchestration TO dt_runtime
GRANT EXECUTE ON OBJECT::dt.RaiseEvent TO dt_runtime
GRANT EXECUTE ON OBJECT::dt.TerminateInstance TO dt_runtime
GRANT EXECUTE ON OBJECT::dt.PurgeInstanceStateByID TO dt_runtime
GRANT EXECUTE ON OBJECT::dt.PurgeInstanceStateByTime TO dt_runtime

-- Internal sprocs
GRANT EXECUTE ON OBJECT::dt._AddOrchestrationEvents TO dt_runtime
GRANT EXECUTE ON OBJECT::dt._CheckpointOrchestration TO dt_runtime
GRANT EXECUTE ON OBJECT::dt._CompleteTasks TO dt_runtime
GRANT EXECUTE ON OBJECT::dt._DiscardEventsAndUnlockInstance TO dt_runtime
GRANT EXECUTE ON OBJECT::dt._GetVersions TO dt_runtime
GRANT EXECUTE ON OBJECT::dt._LockNextOrchestration TO dt_runtime
GRANT EXECUTE ON OBJECT::dt._LockNextTask TO dt_runtime
GRANT EXECUTE ON OBJECT::dt._QueryManyOrchestrations TO dt_runtime
GRANT EXECUTE ON OBJECT::dt._RenewOrchestrationLocks TO dt_runtime
GRANT EXECUTE ON OBJECT::dt._RenewTaskLocks TO dt_runtime
GRANT EXECUTE ON OBJECT::dt._UpdateVersion TO dt_runtime
GRANT EXECUTE ON OBJECT::dt._RewindInstance TO dt_runtime
GRANT EXECUTE ON OBJECT::dt._RewindInstanceRecursive TO dt_runtime

-- Types
GRANT EXECUTE ON TYPE::dt.HistoryEvents TO dt_runtime
GRANT EXECUTE ON TYPE::dt.MessageIDs TO dt_runtime
GRANT EXECUTE ON TYPE::dt.InstanceIDs TO dt_runtime
GRANT EXECUTE ON TYPE::dt.OrchestrationEvents TO dt_runtime
GRANT EXECUTE ON TYPE::dt.TaskEvents TO dt_runtime

GO