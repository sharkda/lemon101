#  README OF LEMON101
my adoption of firebase remote configuration.

1. once the default plist is set, the remoteconf helper can start to emit
default value from the plist, 
since it is Rx, Combine, it requires the first subscriber for 
the publisher to work, we will start with the some_bool
-- actually thought about query the state, however, the design is that 
loaded(Let Result), means that there need to be a result

##using lemon Remote Configuration in Two-frog 
frogCircle is the reason that I evaluate Firebase Remote Congfig and the outcome 
is this lemon project, the main reason is the cost of firebase firestore writing.
if the writing, update of the frogTrail is respond to user query, it will be limited
however, if the update is automatic, there need a way to throttle and remote configure
and this could also be based on the entitlement.



