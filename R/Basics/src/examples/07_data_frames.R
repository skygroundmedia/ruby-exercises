# ## ## ## ## ## ## ## ## ## ## ##
# Data frames are the most commonly used data structures.
# A data frame is a list that contains multiple named vectors of
# the same length. 
#
# Data frames are unique because they are constructed by columns
#

team <- c('Man City', 'Man Utd', 'Totenham', 'Arsenal', 'Chelsea', 'Newcastle', 'Liverpool', 'Stoke')
home_wins <- c(14, 10, 10, 9, 8, 7, 4, 6)
home_draws <- c(0, 1, 2, 2, 2, 4, 8, 4)
home_losses <- c(0, 2, 1, 2, 3, 2, 1, 4)
away_wins <- c(7, 9, 6, 6, 5, 5, 6, 4)
away_draws <- c(3, 3, 3, 2, 5, 3, 1, 2)
away_losses <- c(3, 1, 4, 6, 4, 5, 6, 7)
league_table <- data.frame(team, home_wins, home_draws, home_losses, away_wins, away_draws, away_losses)

# List out the league
league_table

# Find out which team have scored more than 8 away goals
with(league_table, team[home_wins > 8])

# Find out which team has more away wins than home wins.
with(league_table, team[away_wins > home_wins])

