#  README OF LEMON101
my adoption of firebase remote configuration.

1. once the default plist is set, the remoteconf helper can start to emit
default value from the plist, 
since it is Rx, Combine, it requires the first subscriber for 
the publisher to work, we will start with the some_bool
-- actually thought about query the state, however, the design is that 
loaded(Let Result), means that there need to be a result

## using lemon Remote Configuration in Two-frog 
frogCircle is the reason that I evaluate Firebase Remote Congfig and the outcome 
is this lemon project, the main reason is the cost of firebase firestore writing.
### problem statement 
if the writing, update of the frogTrail is respond to user query, it will be limited
however, if the update is automatic, there need a way to throttle and remote configure
and this could also be based on the entitlement.

### daily count
push_per_day: Int = 0, 1,2
push_interval minutes, int. default 9

start_hour_of_day, start_minute_of_day
currently we only have hour_of_day as POC and during testing we will only use
delay_sending. which can be easily revised to hour of day, see below

e.g. ppd = 0, no auto-puhs
ppd = 1, 8:00 AM,

ppd = 2 
p_i  = 9, , p2: 5:00 PM

ppd = 3
p_i = 5, p2: 1:00PM,  p3: 6:00 PM, 

ppd = 4
P-d = 4, p2: 12:00PM, p3:4:00PM, p4:8:00PM

##### delay sending and hour of day.
hour of day can be implemented based on delay sending:
delay sending will trigger based on delta of delay.
hour of day can set the delay delta based on current time Date() and the hour of
day.

