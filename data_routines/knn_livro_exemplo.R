### Usando o algoritmo KNN do pacote class

rid <- c('r1', 'r2', 'r3', 'r4', 'r5', 'r6', 'r7', 'r8', 'r9', 'r10', 'r11', 'r12')
tempo <- c(0.70, 0.40, 0.61, 0.90, 0.80, 0.60, 0.20, 0.40, 0.61, 0.60, 0.50, 1.0)
pre <- c(0.40, 0.50, 0.40, 0.70, 0.30, 1, 0.60, 0.30, 0.20, 0.43, 0.10, 0.20)
sat <- c('sat', 'sat', 'sat', 'sat', 'sat', 'sat', 'ins', 'ins', 'ins', 'ins', 'ins', 'ins')

df <- data.frame(id = rid, tempo = tempo, preço = pre, classe = sat)

library(class)

treinamento <- df[2:12, 2:3]
rotulos <- df[2:12, 4:4]

teste <- df[1:1, 2:3]

y_estimado <- knn(treinamento, teste, rotulos, 3)

