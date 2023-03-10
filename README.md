# Powershell-Whisper-API

Use Powershell to query the Open AI Whisper API.

## Overview

This is a simple PowerShell script that allows you to query the Open AI Whisper API. It bypasses Invoke-RestMethod and uses the underlying .NET. If you've been getting the error "you must provide a model parameter" or "1 validation error for Request\nbody -> file\n field required (type=value_error.missing)" when trying to use Invoke-RestMethod, this script may be useful to you.

## Requirements

- PowerShell v5.0 or higher
- A valid Open AI API key
- A supported audio file in .mp3 format

## Usage

1. Replace the placeholders in the script with your own values:
   - `$apiToken`: Your Open AI API key
   - `$audioFile`: The path to your audio file in .mp3 format
   - `$model`: The name of the Whisper model to use

2. Run the script in a PowerShell console.

## Example

Here's an example of how to use the script:

```powershell
# Replace the placeholders with your own values
$apiToken = "TOKEN"
$audioFile = "C:\path\to\file\audio.mp3"
$model = "whisper-1"

# Create the form data
$formData = @{
    model = $model
}

# Create the HTTP client
Add-Type -AssemblyName System.Net.Http
$httpClient = New-Object System.Net.Http.HttpClient

# Add the authorization header
$httpClient.DefaultRequestHeaders.Authorization = New-Object System.Net.Http.Headers.AuthenticationHeaderValue("Bearer", $apiToken)

# Create the multipart/form-data content
$fileContent = New-Object System.Net.Http.StreamContent([System.IO.File]::OpenRead($audioFile))
$multipartContent = New-Object System.Net.Http.MultipartFormDataContent
$multipartContent.Add($fileContent, "file", [System.IO.Path]::GetFileName($audioFile))
foreach ($key in $formData.Keys) {
    $value = $formData[$key]
    $multipartContent.Add([System.Net.Http.StringContent]::new($value), $key)
}

# Send the request and get the response
$response = $httpClient.PostAsync("https://api.openai.com/v1/audio/transcriptions", $multipartContent).Result
$responseContent = $response.Content.ReadAsStringAsync().Result
$responseContent
