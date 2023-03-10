# Powershell-Whisper-API
Use Powershell to query the Open AI Whisper API

Are you trying to use Invoke-RestMethod and getting the error "you must provide a model parameter" or "1 validation error for Request\nbody -> file\n  field required (type=value_error.missing)"? 

The method in the PowerShellWhisperAPI file above works, it's bypassing Invoke-RestMethod and using the underlying .NET, if you have a solution using just Invoke-RestMethod I'd love to hear it as I have tried every variation and always get the above errors.
