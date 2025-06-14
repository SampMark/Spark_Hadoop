# ==============================================================================
# Arquivo de Configurações Padrão do Spark (spark-defaults.conf)
#
# Descrição:
#   Este arquivo define propriedades padrão que serão usadas ao executar
#   aplicações Spark através do 'spark-submit'. Configurações definidas aqui
#   servem como base, mas podem ser sobrescritas por flags no comando
#   'spark-submit' ou por configurações feitas dentro do código da aplicação.
#
#   As propriedades aqui definidas são aplicáveis tanto para o driver quanto
#   para os executores, dependendo do contexto em que são usadas.
#   As configurações podem ser ajustadas conforme as necessidades do cluster
#   e do workload específico.
# ==============================================================================
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ==============================================================================

# Propriedades de sistema padrão incluídas ao executar spark-submit.
# Isto é útil para definir configurações ambientais padrão.

# Example:
# spark.master                     spark://master:7077
# spark.eventLog.enabled           true
# spark.eventLog.dir               hdfs://namenode:8021/directory
# spark.serializer                 org.apache.spark.serializer.KryoSerializer
# spark.driver.memory              5g
# spark.executor.extraJavaOptions  -XX:+PrintGCDetails -Dkey=value -Dnumbers="one two three"

# ==============================================================================
# Arquivo de Configurações Padrão do Spark (spark-defaults.conf)
#
# Descrição:
#   Este arquivo define propriedades padrão que serão usadas ao executar
#   aplicações Spark através do 'spark-submit'. Configurações definidas aqui
#   servem como base, mas podem ser sobrescritas por flags no comando
#   'spark-submit' ou por configurações feitas dentro do código da aplicação.
#
# Comentários e Traduções:
#   Adicionados em português para cada propriedade, explicando seu propósito
#   e possíveis considerações.
#
# Autor Original das Configurações: Carlos M D Viegas
# Documentação Adicional: Seu Assistente AI
# ==============================================================================

# Propriedades de sistema padrão incluídas ao executar spark-submit.
# Isto é útil para definir configurações ambientais padrão.

# Exemplo (do template original, para referência):
# spark.master                             spark://master:7077
spark.eventLog.enabled                   true
# spark.eventLog.dir                       hdfs://namenode:8021/directory
# spark.serializer                         org.apache.spark.serializer.KryoSerializer
# spark.driver.memory                      5g
# spark.executor.extraJavaOptions          -XX:+PrintGCDetails -Dkey=value -Dnumbers="one two three"

# ------------------------------------------------------------------------------
# Configurações do Cluster e Deploy
# ------------------------------------------------------------------------------
# O gerenciador de cluster ao qual se conectar.
# Opções comuns:
#   - yarn: Para rodar no YARN.
#   - spark://HOST:PORT: Para conectar a um cluster Spark Standalone.
#   - mesos://HOST:PORT: Para conectar a um cluster Mesos.
#   - local: Para rodar localmente em uma única JVM (para testes/desenvolvimento).
#   - local[K]: Para rodar localmente com K threads worker.
#   - local[*]: Para rodar localmente com tantos threads worker quanto cores de CPU disponíveis.
spark.master                            yarn

# Modo de deploy do Spark ao submeter para um cluster (ex: YARN).
# Opções:
#   - client: O Driver Spark roda na máquina onde 'spark-submit' foi chamado.
#             Bom para depuração e UIs interativas, mas a máquina cliente deve
#             permanecer ativa durante toda a execução da aplicação e ter boa
#             conectividade com o cluster.
#   - cluster: O Driver Spark roda dentro de um dos contêineres do cluster
#              (ex: no ApplicationMaster do YARN). Preferível para jobs de produção,
#              pois a submissão não depende da máquina cliente após o envio.
spark.submit.deployMode                 client

# ------------------------------------------------------------------------------
# Configurações do Spark Connect (para acesso remoto ao cluster Spark)
# ------------------------------------------------------------------------------
# Habilita o Spark Connect Server, permitindo que clientes remotos
# (ex: aplicações em outras linguagens, notebooks) se conectem e executem
# comandos Spark no cluster.
spark.connect.enabled                   true

# Porta na qual o Spark Connect Server escutará por conexões.
# O padrão é 15002.
spark.connect.server.port               15002

# ------------------------------------------------------------------------------
# Configurações de Rede e Recursos do Driver
# ------------------------------------------------------------------------------
# Endereço de host ou IP ao qual os sockets de escuta do Driver se vincularão.
# Em ambientes de contêiner ou com múltiplos IPs, '0.0.0.0' faz o driver
# escutar em todas as interfaces de rede disponíveis, facilitando a conexão
# dos executores ao driver.
spark.driver.bindAddress                0.0.0.0

# Quantidade de memória a ser usada para o processo Driver (ex: 1g, 2048m).
# Padrão Spark: 1g.
# O valor '1024m' (1GB) é um bom ponto de partida para aplicações pequenas a médias.
# Aumente se o driver estiver realizando operações pesadas (ex: collect() de grandes datasets,
# construção de planos complexos no Spark SQL, ou se a lógica do driver for intensiva).
spark.driver.memory                     1024m

# ------------------------------------------------------------------------------
# Configurações de Recursos do Executor
# ------------------------------------------------------------------------------
# Quantidade de memória a ser usada por cada processo Executor (ex: 1g, 2048m).
# Padrão Spark: 1g.
# O valor '1536m' (1.5GB) é um bom começo. O tamanho ideal depende da sua aplicação,
# dos dados processados e da memória disponível nos nós workers do YARN.
# Considere também o overhead de memória (spark.executor.memoryOverhead).
spark.executor.memory                   1536m

# Memória alocada para o ApplicationMaster (AM) do Spark quando rodando no YARN.
# O AM é responsável por negociar recursos com o YARN e monitorar os executores.
# Padrão Spark: Mesmo que spark.driver.memory (se deployMode=cluster) ou um valor menor.
# O valor '1024m' (1GB) é geralmente suficiente para a maioria das aplicações.
# Esta propriedade é específica do YARN.
spark.yarn.am.memory                    1024m

# Quantidade de memória adicional (off-heap) a ser alocada por executor PySpark.
# Usada para armazenar dados Python e para comunicação entre a JVM e o processo Python.
# Padrão Spark: Não definido explicitamente aqui, mas o executor Python gerencia sua própria memória.
# O valor '384m' é um valor específico. Se você não usa PySpark extensivamente ou não tem
# problemas de memória com Python, pode não precisar desta configuração ou ajustá-la.
# Esta propriedade foi mais relevante em versões mais antigas do Spark.
# Em Spark 3+, a gestão de memória para PySpark foi melhorada.
# Considere `spark.executor.pyspark.memory` se estiver usando PySpark.
# Se o valor `spark.executor.pyspark.memory` está no arquivo, o comentário acima é válido.
# O arquivo fornecido tem:
spark.executor.pyspark.memory           384m # Este valor pode ser pequeno. Se usar PySpark com grandes DataFrames, pode precisar aumentar.

# Overhead de memória (off-heap) por executor, em MB.
# Esta é a memória reservada além do `spark.executor.memory` para sobrecargas da JVM,
# strings, buffers NIO, etc.
# Padrão Spark: max(384MB, 0.10 * spark.executor.memory).
# O valor '384m' é o mínimo. Se `0.10 * spark.executor.memory` for maior, esse valor será usado.
# Para `spark.executor.memory = 1536m`, 10% é 153.6MB. Então, 384MB será usado.
# É importante dimensionar isso corretamente para evitar erros de OutOfMemory no contêiner YARN.
spark.executor.memoryOverhead           384m
# Você pode também usar uma porcentagem, ex: spark.executor.memoryOverheadFactor=0.1 (padrão)
# e spark.yarn.executor.memoryOverheadFactor=0.1875 (padrão YARN).
# A propriedade explícita `spark.executor.memoryOverhead` (em MB) tem precedência.

# Número de cores (vCores no YARN) a serem usados por cada executor.
# Padrão Spark: 1 (em YARN e Standalone), ou todos os cores disponíveis (em modo local).
# O valor '2' sugere que cada executor pode processar 2 tarefas em paralelo.
# Um bom valor típico é entre 1 e 5, dependendo da natureza da carga de trabalho (CPU-bound vs I/O-bound)
# e dos vCores disponíveis nos nós workers.
spark.executor.cores                    2

# ------------------------------------------------------------------------------
# Configurações de Log de Eventos (Event Logging) e History Server
# ------------------------------------------------------------------------------
# Habilita ou desabilita o log de eventos do Spark.
# Os logs de eventos são necessários para que o Spark History Server possa reconstruir
# a UI de aplicações concluídas. Essencial para depuração e monitoramento pós-execução.
spark.eventLog.enabled                  true

# Diretório base onde os logs de eventos do Spark são armazenados.
# Deve ser um diretório em um sistema de arquivos compartilhado acessível pelo
# History Server (ex: HDFS, S3).
# 'hdfs://spark-master:9000/user/myuser/sparkLogs' aponta para um diretório no HDFS.
#   - 'spark-master:9000': Endereço do NameNode (fs.defaultFS).
#   - '/user/myuser/sparkLogs': Caminho no HDFS. Certifique-se que este diretório exista
#     e que as aplicações Spark tenham permissão de escrita nele.
spark.eventLog.dir                      hdfs://spark-master:9000/user/myuser/sparkLogs

# Habilita o log de eventos de atualização de blocos (BlockManager).
# Pode gerar muitos logs, mas útil para depurar problemas de armazenamento em cache e shuffle.
spark.eventLog.logBlockUpdates.enabled  true

# Habilita a compressão para os arquivos de log de eventos.
# Ajuda a economizar espaço de armazenamento, especialmente para aplicações de longa duração
# ou com muitos eventos. Codecs como snappy, lz4, zstd podem ser usados (ver `spark.eventLog.compression.codec`).
spark.eventLog.compress                 true

# Nome da classe que implementa o backend de histórico da aplicação.
# `org.apache.spark.deploy.history.FsHistoryProvider` é o provedor padrão, que lê
# logs de eventos de um sistema de arquivos (como HDFS ou local).
spark.history.provider                  org.apache.spark.deploy.history.FsHistoryProvider

# Para o FsHistoryProvider, a URL do diretório contendo os logs de eventos
# das aplicações a serem carregados pelo History Server.
# Deve corresponder ao `spark.eventLog.dir` (ou a um diretório pai se houver subdiretórios por aplicação).
spark.history.fs.logDirectory           hdfs://spark-master:9000/user/myuser/sparkLogs

# O intervalo (em segundos, ou com unidades como '10s', '1m') em que o
# FsHistoryProvider verifica por logs novos ou atualizados no `logDirectory`.
# Padrão: 10s.
spark.history.fs.update.interval        10s

# A porta à qual a interface web do Spark History Server se vinculará.
# Padrão: 18080.
spark.history.ui.port                   18080

# ------------------------------------------------------------------------------
# Configurações Específicas do YARN
# ------------------------------------------------------------------------------
# Diretório de staging no HDFS usado ao submeter aplicações para o YARN.
# O Spark usa este diretório para enviar arquivos de job (JARs, etc.) para o HDFS
# antes que o ApplicationMaster seja lançado.
# Padrão YARN: /user/${user.name}/.sparkStaging ou similar no /tmp do HDFS.
# Definir explicitamente é uma boa prática.
spark.yarn.stagingDir                   hdfs://spark-master:9000/user/myuser/.sparkStaging

# Lista de JARs ou diretórios contendo JARs a serem distribuídos para
# os contêineres YARN (ApplicationMaster e Executores).
# Útil se suas aplicações dependem de bibliotecas que não estão no classpath padrão do Spark
# ou do Hadoop nos nós.
# 'hdfs://spark-master:9000/sparkLibs/*' sugere que os JARs do Spark ou bibliotecas
# comuns estão em um diretório `/sparkLibs` no HDFS.
# O Spark geralmente lida com a distribuição de seus próprios JARs. Esta propriedade é
# mais para JARs adicionais ou para sobrescrever a localização dos JARs do Spark.
spark.yarn.jars                         hdfs://spark-master:9000/sparkLibs/*

# ------------------------------------------------------------------------------
# Configurações de Alocação Dinâmica de Executores
# ------------------------------------------------------------------------------
# Habilita ou desabilita a alocação dinâmica de executores.
# Com a alocação dinâmica, o Spark pode adicionar ou remover executores com base
# na carga de trabalho, otimizando o uso de recursos.
# Requer um serviço de shuffle externo (`spark.shuffle.service.enabled=true`).
spark.dynamicAllocation.enabled         true

# Número inicial de executores a serem alocados quando a alocação dinâmica
# está habilitada.
# Pode ser útil para garantir que a aplicação comece com um número mínimo de
# recursos imediatamente.
spark.dynamicAllocation.initialExecutors 1

# Se um executor permanecer ocioso por mais do que esta duração (em segundos),
# ele será removido.
# Padrão: 60s.
spark.dynamicAllocation.executorIdleTimeout 60s # 's' é opcional, mas bom para clareza

# Número mínimo de executores a serem mantidos no cluster quando a alocação
# dinâmica está habilitada.
# Padrão: 0.
spark.dynamicAllocation.minExecutors    1

# Número máximo de executores que o Spark pode alocar durante a execução
# quando a alocação dinâmica está habilitada.
# Padrão: Infinito (Integer.MAX_VALUE). É uma boa prática definir um limite superior
# para evitar que uma aplicação consuma todos os recursos do cluster.
spark.dynamicAllocation.maxExecutors    10

# ------------------------------------------------------------------------------
# Configurações do Serviço de Shuffle
# ------------------------------------------------------------------------------
# Habilita ou desabilita o serviço de shuffle externo.
# Necessário para a alocação dinâmica de executores no YARN.
# O serviço de shuffle externo é executado nos NodeManagers do YARN (configurado
# via `yarn.nodemanager.aux-services` em `yarn-site.xml`) e permite que os
# executores sejam removidos sem perder os dados de shuffle que eles escreveram.
spark.shuffle.service.enabled           true

# ------------------------------------------------------------------------------
# Configurações da Interface de Usuário (UI) do Spark
# ------------------------------------------------------------------------------
# Habilita ou desabilita a UI web do Spark para o Driver/Aplicação.
# A UI da aplicação (geralmente na porta 4040) fornece informações sobre stages,
# tarefas, armazenamento, etc., em tempo real.
# Se definido como 'false', a UI da aplicação não será iniciada.
# O comentário original "spark history server is used instead" sugere que a intenção
# é confiar apenas no History Server para informações pós-execução. No entanto,
# a UI da aplicação em tempo real é muito útil para monitoramento durante a execução.
# Considere se realmente deseja desabilitá-la.
spark.ui.enabled                        false

# ------------------------------------------------------------------------------
# Configurações do Spark SQL
# ------------------------------------------------------------------------------
# Número padrão de partições a serem usadas durante operações de shuffle
# em Spark SQL (ex: joins, aggregations).
# Padrão: 200.
# O valor '16' é muito baixo para datasets grandes e pode levar a partições enormes
# e problemas de desempenho ou memória.
# Um bom ponto de partida é 1-2x o número total de cores de executor no cluster.
# Ajuste com base no tamanho dos seus dados e na complexidade das queries.
spark.sql.shuffle.partitions            16
# RECOMENDAÇÃO: Aumentar este valor significativamente (ex: para 100, 200, ou mais)
# se você processar grandes volumes de dados com Spark SQL.

# O local padrão no sistema de arquivos para o "warehouse" do Spark SQL,
# onde tabelas gerenciadas (criadas sem um `LOCATION` explícito) são armazenadas.
# `hdfs://spark-master:9000/user/myuser/sparkWarehouse` aponta para um diretório no HDFS.
# Certifique-se que este diretório exista e tenha as permissões corretas.
spark.sql.warehouse.dir                 hdfs://spark-master:9000/user/myuser/sparkWarehouse

# Habilita o uso do Apache Arrow para otimizar a transferência de dados
# entre JVM (Spark) e Python (Pandas) ao usar `toPandas()` ou `createDataFrame()`
# a partir de um Pandas DataFrame. Pode melhorar significativamente o desempenho.
# Requer PyArrow instalado no ambiente Python.
spark.sql.execution.arrow.pyspark.enabled true

# ------------------------------------------------------------------------------
# Configurações de Serialização
# ------------------------------------------------------------------------------
# Classe do serializador a ser usado para serializar objetos RDDs que são
# enviados pela rede ou escritos em disco.
# `org.apache.spark.serializer.KryoSerializer` é geralmente mais rápido e compacto
# que o serializador Java padrão, especialmente para classes customizadas.
# Requer que as classes a serem serializadas sejam registradas para melhor desempenho.
spark.serializer                        org.apache.spark.serializer.KryoSerializer
# Para registrar classes com Kryo:
# spark.kryo.registrator                com.suaempresa.SeuKryoRegistrator
# spark.kryo.registrationRequired       true (para forçar o registro e evitar fallbacks lentos)

# ------------------------------------------------------------------------------
# Opções Java Adicionais
# ------------------------------------------------------------------------------
# Define opções Java extras para o processo Driver.
#   - `-Dderby.system.home=/home/myuser/derby-metastore`: Configura o diretório home
#     para o metastore Derby embutido do Spark SQL (usado se nenhum Hive Metastore externo
#     estiver configurado). É bom definir para um local específico e persistente.
#   - `-Dderby.stream.error.file=/home/myuser/derby-metastore/derby.log`: Define o
#     arquivo de log de erros do Derby.
# Certifique-se que o diretório `/home/myuser/derby-metastore` exista e tenha permissão de escrita.
spark.driver.extraJavaOptions           -Dderby.system.home=/home/myuser/derby-metastore -Dderby.stream.error.file=/home/myuser/derby-metastore/derby.log

# (Propriedade original do exemplo, não presente no seu arquivo mas relevante)
# Opções Java extras para os processos Executor.
# spark.executor.extraJavaOptions       -XX:+PrintGCDetails -Dkey=value
# ------------------------------------------------------------------------------
