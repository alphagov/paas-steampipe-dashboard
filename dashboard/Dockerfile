FROM turbot/steampipe
EXPOSE 8080
RUN  steampipe plugin install steampipe aws config csv github googlesheets net prometheus rss terraform whois zendesk
WORKDIR .
COPY dashboard dashboard
COPY data data
COPY dashboard/config/csv.spc /home/steampipe/.steampipe/config
CMD ["steampipe", "dashboard", "--dashboard-port", "8080", "--dashboard-listen=network", "--workspace-chdir", "dashboard"]
