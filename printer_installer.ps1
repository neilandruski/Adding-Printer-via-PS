# use a loop to verify the printer is either already installed/skip or 
[string]$server = 'PrintServer'
[string[]]$printerList = ["Add", "Your", "Printers", "Here"]

foreach ($printer in $printerList)
{

	Write-Output "Adding $printer ....." -NoEnumerate
	[bool]$printerInstalled = $false
	
	do {
    	# verify printer isn't locally installed. 
		if(Get-Printer | Where-Object {$_.Name -ilike "*$printer*"} | Where-Object{$_.Name -notlike "Local"})
        {
            Write-Output "*******$printer has been successfully installed*******" -NoEnumerate
            $printerInstalled = $true
        }
        else
        {
            Add-Printer -ConnectionName "\\$server\$printer" 
            $printerInstalled = $false
            Continue 
        }
    } until ($printerInstalled = $true)
}