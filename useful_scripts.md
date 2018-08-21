# MAILX 
````
echo test | mailx -a /apps/home/FileToSend.docx -s test piotr@myemail.com
```

```shell
echo -e "Hi, \n\nCisco ASA firewall report  attached\n\nKind Regards\n\nPiotr" | mailx -a /apps/home/filePath/cisco_asa_report_directory/cisco_asa_report.docx -s "The Client Cisco Firewall Report" piotr.szczepanski@mymail.com
```
