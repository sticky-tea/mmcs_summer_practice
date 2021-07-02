## Результат теста времени:

## ПК
### ГОСТ 28147-89

|  Size | Time, ms |    Speed   |
|:-----:|:--------:|------------|
| 200kb |    18    | 88.8 Mbps  |
| 1mb   |    94    | 87.14 Mbps |
| 10mb  |    936   | 87.52 Mbps |
| 100mb |   9252   | 88.53 Mbps |

### AES

|  Size | Time, ms |    Speed   |
|:-----:|:--------:|------------|
| 200kb |    67    | 23.8 Mbps  |
| 1mb   |    340   | 24.08 Mbps |
| 10mb  |   3356   | 26.8 Mbps  |
| 100mb |   33498  | 24.4 Mbps  |

Как видно из результатов, ГОСТ 28147-89 "Магма" в среднем в три раза быстрее алгоритма AES

## Pynq Z2
### AES

|  Size | Time, ms |    Speed   |
|:-----:|:--------:|:----------:|
| 200kb |    39    | 41.02 Mbps |
| 1mb   |    209   | 40.00 Mbps |
| 10mb  |   3738   | 21.62 Mbps |
| 100mb |   21701  | 32.38 Mbps |

Было произведено несколько замеров, результаты которых различались на допустимую погрешность. Интересно, что скорость работы алгоритма при шифровании 100мб на Pynq Z2 стабильно заметно меньше скорости шифрования других файлов. Вероятно, это связано с алгоритмом доступа к памяти в Zynq 7020

Таким образом, ожидаемая скорость работы алгоритма ГОСТ 28147-89 на Pynq Z2 находится из соотношения:

$$ gost_{pynq} = \frac{gost_{pc} * aes_{pynq}}{aes_{pc}} $$

что соответственно:

|  Size |    Speed    |
|:-----:|:-----------:|
| 200kb | 153.04 Mbps |
| 1mb   | 144.75 Mbps |
| 10mb  | 70.60 Mbps  |
| 100mb | 117.47 Mbps |

что в среднем **121.46 Mbps**

## Тест времени на Zynq 7020

Результат теста времени выполнения алгоритма AES без использования ПЛИС:

|  Size | Time, ms |   Speed   |
|:-----:|----------|:---------:|
| 200kb | 1059     | 1.50 Mbps |
| 1mb   | 5475     | 1.46 Mbps |
| 10mb  | 98240    | 0.81 Mbps |
| 100mb | 545992   | 1.46 Mbps |

Видно, что ПЛИС даёт прирост в скорости примерно в двадцать пять раз, превосходя скорость выполнения даже на ПК (Intel Core i5)

## Методы улучшения текущей реализации

Очевидно, что данная реализация AES может быть улучшена, что в теории может увеличить скорость в несколько раз. Некоторые проблемы и их методы улучшения:
1. В силу того, что HLS IP-блока имеет пропускную способность в 345600 символов, в функции string_AES_En_De приходится делить входящий буфер на части, что сильно влияет на скорость выполнения. Теоретически, этот фрагмент можно заменить, используя инструменты пакета Numpy;
2. Высокий прирост производительности должен дать переход от языка Python к компилируемым языкам, например С; 
3. Максимальный прирост должен дать отказ от использования микроконтроллера для управления IP-блоком и переход к ПЛИС