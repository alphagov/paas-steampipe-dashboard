# Decisions

a log of decisions

- snapshot all data to local csv files so that is separate from the dashboard itself
- keep data out of the repo
- after looking at the cf plugin https://github.com/SvenTo/steampipe-plugin-cf decided to pull data from the api in json format using cf curl because I need greater coverage of CF and I dont have time to write a plugin
- modularise dashboard
- put sql in separate files so they can be tested on the command line easily
- use AWS copilot to host on AWS using ECS/Fargate
- use the GDS CLI to access the AWS accounts in a secure manner using MFA
- put settings in settings.csv
- separate data curation into a separate private repository that others can use to analyse the data with other tools, gsheets, data studio, google colab, metabase
- move repo to alphagov org
- host dashboard as a private back end app
- provide controlled access via an nginx reverse proxy
- add basic auth
- restrict access to VPN
- user TLS for front end
- put data in  a separate data directory and add data/**/*.csv to csv config
- generate the nginx configuration from a template substituting environment variables using envsubst
