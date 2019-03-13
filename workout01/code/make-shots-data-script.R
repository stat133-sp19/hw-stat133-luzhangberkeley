#####################################
# title: Data Preparation
# description: The primary goal of this stage is to create a csv data file shots-data.csv that will contain the required variables to be used in the visualization phase
# inputs:andre-iguodala.csv,draymond-green.csv,kevin-durant.csv,klay-thompson.csv,stephen-curry.csv
# outputs:andre-iguodala-summary.txt,draymond-green-summary.txt,kevin-durant-summary.txt,klay-thompson-summary.txt,stephen-curry-summary.txt,shots-data.csv,shots-data-summary.txt
#####################################

# add a column name
ai <- read.csv("../data/andre-iguodala.csv", stringsAsFactors=FALSE)
dg <- read.csv("../data/draymond-green.csv", stringsAsFactors=FALSE)
kd<- read.csv("../data/kevin-durant.csv", stringsAsFactors=FALSE)
kt<- read.csv("../data/klay-thompson.csv", stringsAsFactors=FALSE)
sc<- read.csv("../data/stephen-curry.csv", stringsAsFactors=FALSE)

ai$name="andre iguodala"
dg$name="draymond green"
kd$name="kevin durant"
kt$name="klay thompson"
sc$name="stephen curry"

# modificate the value of shou_made_flag
ai$shot_made_flag[ai$shot_made_flag=="n"]="shot_no"
ai$shot_made_flag[ai$shot_made_flag=="y"]="shot_yes"

dg$shot_made_flag[dg$shot_made_flag=="n"]="shot_no"
dg$shot_made_flag[dg$shot_made_flag=="y"]="shot_yes"

kd$shot_made_flag[kd$shot_made_flag=="n"]="shot_no"
kd$shot_made_flag[kd$shot_made_flag=="y"]="shot_yes"

kt$shot_made_flag[kt$shot_made_flag=="n"]="shot_no"
kt$shot_made_flag[kt$shot_made_flag=="y"]="shot_yes"

sc$shot_made_flag[sc$shot_made_flag=="n"]="shot_no"
sc$shot_made_flag[sc$shot_made_flag=="y"]="shot_yes"

# Add a column `minute`
ai$minute <- ai$period*12-ai$minutes_remaining
dg$minute <- dg$period*12-dg$minutes_remaining 
kd$minute <- kd$period*12-kd$minutes_remaining
kt$minute <- kt$period*12-kt$minutes_remaining
sc$minute <- sc$period*12-sc$minutes_remaining

# output
sink(file = '../output/andre-iguodala-summary.txt')
summary(ai)
sink()

sink(file = '../output/draymond-green-summary.txt')
summary(dg)
sink()

sink(file = '../output/kevin-durant-summary.txt')
summary(kd)
sink()

sink(file = '../output/klay-thompson-summary.txt')
summary(kt)
sink()

sink(file = '../output/stephen-curry-summary.txt')
summary(sc)
sink()

# stack tables togethe
bind <- rbind(ai,dg,kd,kt,sc)

# export it 
write.csv(
  x=bind,
  file='../data/shots-data.csv')


# export the summary of the assembled table
sink(file='../output/shots-data-summary.txt')
summary(bind)
sink





  
