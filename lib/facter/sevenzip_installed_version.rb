# Fact: sevenzip_installed_version
#
# Purpose:
#   Returns the version-number for the actualy installed 7-Zip
#
# Resolution:
#   Windows:
#     Uses the powershell to read the versionnumber from the registry
#
# Caveats:
#   currently only windows 7 and windows 10

Facter.add(:sevenzip_installed_version) do
  setcode do
    if Facter.value(:kernel) == 'windows'
      command = 'powershell -NoProfile -NonInteractive -NoLogo -ExecutionPolicy Bypass -command "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where {$_.DisplayName -like \"*7-zip*\"} | Select-Object DisplayVersion | Format-Table -HideTableHeaders"'

      if name = Facter::Core::Execution.exec(command) and name =~ /([0-9\.]+)/
        return_value = $1
      end
    else
      return_value = 'not-a-supported-os'
    end
  end
end
