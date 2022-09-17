FROM turbot/steampipe
# Setup prerequisites (as root)
EXPOSE 8080
RUN  steampipe plugin install steampipe config aws csv github googlesheet net prometheus rss terraform zendesk
WORKDIR .
ADD *.csv .
ADD *.json .
ADD config .
ADD dashboards .
CMD ["steampipe", "dashboard", "--dashboard-port", "8080", "--dashboard-listen=network"]