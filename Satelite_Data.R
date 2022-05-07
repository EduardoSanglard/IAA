# 1. Treine modelos RandomForest, SVM e RNA para predição destes dados. 
# 2. Escolha o melhor modelo com base em suas matrizes de confusão. 
# 3. Treine o modelo final com todos os dados e faça a predição na base completa. 
# 4. Analise o resultado.
# 5. Salve este modelo final 


# load the library mlbench
library(mlbench)
library(dplyr)

df_satellite = Satellite

df_satellite <- df_satellite[,c(17, 18, 19 , 20, 37)]

head(df_satellite)
str(df_satellite)

df_satellite$classes

# write.csv2(df_satellite, "satellite.csv")

set.seed(123)

classes = c('cotton crop', 'grey soil', 'damp grey soil', 'very damp grey soil', 'vegetation stubble', 'red soil')

df_train = df_satellite[0,]
df_test = df_satellite[0,]

for (classe in classes) {
  df_satelliteClass <- df_satellite[df_satellite$classes == classe, ]
  print(nrow(df_satelliteClass))
  train_test <- sample(c(rep(0, 0.7 * nrow(df_satelliteClass)), rep(1, 0.3 * nrow(df_satelliteClass))))
  df_train <- rbind(df_train, df_satelliteClass[train_test == 0, ])
  df_test <- rbind(df_test, df_satelliteClass[train_test == 1, ])
  
}

# Dimensões de Treinamento e Teste
dim(df_train)
dim(df_test)

# Divisão SEM train/test por classe
# train_test <- sample(c(rep(0, 0.7 * nrow(df_satellite)), rep(1, 0.3 * nrow(df_satellite))))
# df_train <- df_satellite[train_test == 0, ]
# df_test <- df_satellite[train_test == 1, ]

# Dimensões de Treinamento e Teste
# dim(df_train)
# dim(df_test)

# Run the model
rf_default <- train(survived~.,
                    data = df_train,
                    method = "rf",
                    metric = "Accuracy",
                    trControl = trControl)
# Print the results
print(rf_default)
