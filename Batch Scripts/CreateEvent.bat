eventcreate /t information /id 100 /l application /so "MyScript" /d "My custom event message"
::  /t information: Specifies the event type as "Information". Other options include "Warning" and "Error".
::  /id 100: Specifies the event ID. You can choose any number between 1 and 65535.
::  /l application: Specifies the event log to write to. Other options include "System" and "Security".
::  /so "MyScript": Specifies the source of the event. This is typically the name of your script or application.
::  /d "My custom event message": Specifies the event message to log. This can be any text string.
