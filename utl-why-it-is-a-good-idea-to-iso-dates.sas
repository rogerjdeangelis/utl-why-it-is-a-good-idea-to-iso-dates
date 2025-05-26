%let pgm=utl-why-it-is-a-good-idea-to-iso-dates;

%stop_submission;

why it is a good idea to iso dates

Problem
  select the date closest be before a start data in an unordered array of dates

ISO dates (YYYY-MM-DD) sort correctly as plain text, just like numbers do.
They are also easy for humans to read and understand, reducing ambiguity.
They even lineup in columns for documentation purposes.
Some relational databases like sqllite can use iso string dates for day differences..


INPUT

data sd1.have;
  input PATIENT$ (START DT1 DT2 DT3 DT4 DT5) ($11.);
cards4;
001 2025-02-13 2025-02-12 2025-02-23 2025-03-10 2025-03-18 2025-04-25
001 2025-02-27 2025-02-12 2025-02-23 2025-03-10 2025-03-18 2025-04-25
001 2025-04-07 2025-02-12 2025-02-23 2025-03-10 2025-03-18 2025-04-25
001 2025-04-27 2025-02-12 2025-02-23 2025-03-10 2025-03-18 2025-04-25
;;;;
run;quit;

PROCESS

data sd1.want;
  set sd1.have;
  array dte[5] dt1 dt2 dt3 dt4 dt5;
  call sortc(of dte[*]);
  do i=1 to 5;
    if dte[i] < start then closest_before=dte[i];
  end;
  keep patient start closest_before;
run;quit;

OUTUT

                          CLOSEST_
PATIENT      START         BEFORE

  001      2025-02-13    2025-02-12
  001      2025-02-27    2025-02-23
  001      2025-04-07    2025-03-18
  001      2025-04-27    2025-04-25

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
