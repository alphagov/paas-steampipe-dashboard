# Decisions

a log of decisions

- snapshot all data to local csv files so that is separate from the dashboard itself
- keep data out of the repo
- after looking at the cf plugin https://github.com/SvenTo/steampipe-plugin-cf decided to pull data from the api in json format using cf curl because I need greater coverage of CF and I dont have time to write a plugin
- modularise dashboard
- put sql in separate files so they can be tested on the command line easily
- use AWS copilot to host on AWS
- use the GDS CLI to access the AWS accounts in a secure manner using MFA
- put settings in settings.csv
- separate data curation into a separate private repository that others can use to analyse the data with other tools, gsheets, data studio, google colab
-  move repo to alpghagov org
