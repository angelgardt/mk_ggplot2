library(ggplot2)

share <- read.csv('https://raw.githubusercontent.com/angelgardt/mk_ggplot2/master/sharexp_data.csv')
str(share)

share$setsize <- as.factor(share$setsize)
share$time1 <- share$time1*1000
share$time2 <- share$time2*1000

ggplot(data = share, aes(x = time1, y = time2, color = platform)) +
  geom_point(alpha = .9) +
  geom_smooth(method = 'lm')

ggplot(share, aes(time1)) +
  geom_density()

ggplot(share, aes(time1)) +
  geom_histogram(binwidth = 100)


ggplot(share, aes(setsize, fill = platform)) +
  geom_bar(position = position_dodge())


share <- subset(share, share$trialtype != 'both')

pd <- position_dodge(.5)
ggplot(share, aes(setsize, time1, color = platform,
                  shape = trialtype, group = interaction(trialtype, platform))) +
  stat_summary(fun.y = mean, geom = 'line',
               position = pd, linetype = 'dashed') +
  stat_summary(fun.y = mean, geom = 'point',
               position = pd, size = 2) +
  stat_summary(fun.data = mean_cl_boot, geom = 'errorbar',
               position = pd, width = .3) +
  theme_bw() +
  labs(x = 'Количество стимулов в пробе', y = 'Время, мс',
       color = 'Платформа', shape = 'Тип пробы',
       title = 'Взаимодействие факторов',
       subtitle = 'Тип пробы + Платформа + Количество стимулов',
       caption = 'отображен 95% доверительный интервал') +
  scale_color_manual(values = c('royalblue4', 'brown3'),
                     labels = c('Android', 'iOS')) +
  scale_shape_manual(values = c(15, 17),
                     labels = c('Three Dots', 'Outgoing Tray')) 
  theme(legend.position = 'bottom')
ggsave('graph1.png')

getwd()
