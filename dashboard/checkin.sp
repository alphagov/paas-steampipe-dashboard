dashboard "checkin" {
  title = "GOV.UK PaaS decommision check-in dashboard"

  text {
      width = 8
      type = "markdown"
      value = <<-EOM
        A dashboard for the fornightly Digital Service platform check in. see [story](https://www.pivotaltracker.com/n/projects/1275640/stories/183567434)
          
      EOM
  }

  container {  
      title = "Remaining time"
      card {
        base = card.countdown_days
      }
      card {
        base = card.countdown_working_days
      }
      card {
        base = card.countdown_weeks
      }
    }

text {
      width = 8
      type = "markdown"
      value = <<-EOM
        # potential metrics
        |#|metric|source|description|
        |-|----|----|---------------|
        |1| working days remaining |calculated| various ways to represent the available time to work on the migrations |
        |2| rate of downward trend of bills |paas-billing| suggest we start with a comparison with the previous month showing the delta and an arrow for the direction of the change similar to the monthly cyber report |
        || % of tenant readiness at RAG |googlesheet| the rag rating, see the [checkin deck](https://docs.google.com/presentation/d/1bicwVxNwu1yhmeEZZSgbSl1wJ10SblkZiYv389L4uNE/edit#slide=id.g17b3a3cd02a_2_56)|
        || counts of platform things | aiven, aws, cf | we can readily count all the platform things so we need to decide which ones matter most, suggest some high level things like the count of apps hosted | 
        || all civil servants on the team have a new role lined up|googlesheet|this will probably be a manually curated spreadsheet | 
        || service level indicators all green |?| see [checkin deck](https://docs.google.com/presentation/d/1bicwVxNwu1yhmeEZZSgbSl1wJ10SblkZiYv389L4uNE/edit#slide=id.g14d65cdb2b3_0_0)| 
     
      [github](https://github.com/alphagov/paas-steampipe-dashboard/tree/main/dashboard)
      EOM
  }
  tags = {
  service = "checkin"
  type     = "dashboard"
  }


}


