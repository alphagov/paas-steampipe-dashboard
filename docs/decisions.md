# Decisions

a log of decisions

- snapshot all data to local csvs so that is separate from the dashboard itself
- after looking at the cf plugin https://github.com/SvenTo/steampipe-plugin-cf decided to pull data from the api in json format using cf curl because I need greater coverage of CF and I dont have time to write a plugin
- use AWS copilot to host on AWS
- use the GDS CLI to access the AWS accounts in a secure manner using MFA
