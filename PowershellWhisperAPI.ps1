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