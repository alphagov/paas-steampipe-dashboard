FROM turbot/steampipe
# Setup prerequisites (as root)
EXPOSE 8080
RUN  steampipe plugin install steampipe aws config csv github googlesheets net prometheus rss terraform whois zendesk
WORKDIR .
ADD dashboard/config/csv.spc /home/steampipe/.steampipe/config
ADD data ./data
ADD dashboard ./dashboard
CMD ["steampipe", "dashboard", "--dashboard-port", "8080", "--dashboard-listen=network", "--workspace-chdir", "dashboard"]
