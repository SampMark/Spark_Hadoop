<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<!--
  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License. See accompanying LICENSE file.
-->

<configuration>
    <!--
        core-site.xml contém parâmetros de configuração para Hadoop Core,
        como I/O, RPC, e o sistema de arquivos padrão.
    -->

    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://${HDFS_NAMENODE_HOST}:9000</value>
        <description>
            O nome do sistema de arquivos padrão.
            Uma URI cujo esquema e autoridade determinam a implementação do FileSystem.
            O esquema 'hdfs' indica o Hadoop Distributed FileSystem.
            'spark-master' é o hostname (ou alias do contêiner Docker) onde o NameNode está sendo executado.
            '9000' é a porta padrão para o NameNode IPC.
            Esta é uma configuração CRUCIAL. Certifique-se que 'spark-master' seja resolvível
            por todos os nós do cluster.
        </description>
    </property>

    <property>
        <name>dfs.replication</name>
        <value>${DFS_REPLICATION}</value>
        <description>
            O fator de replicação padrão para novos arquivos no HDFS.
            ${DFS_REPLICATION} deve ser definido como uma variável de ambiente ou substituído
            por um valor numérico (ex: 3) antes de iniciar o Hadoop.
            Um fator de replicação de 3 é comum em ambientes de produção para garantir
            resiliência e disponibilidade, mas pode ser ajustado conforme necessário.
    </property>

    <property>
        <name>hadoop.http.staticuser.user</name>
        <value>myuser</value>
        <description>
            O usuário a ser usado pelas UIs web do Hadoop (como a UI do NameNode)
            para navegar no sistema de arquivos quando a autenticação está desabilitada (padrão).
            'myuser' deve ser o usuário que executa os processos Hadoop ou um usuário com
            permissões apropriadas no HDFS.
            Para ambientes de desenvolvimento, isso é geralmente aceitável. Em produção,
            considere as implicações de segurança.
        </description>
    </property>

    <!-- Propriedades Adicionais Sugeridas para core-site.xml -->

    <property>
        <name>hadoop.tmp.dir</name>
        <value>/opt/hadoop_tmp_data/tmp</value>
        <!-- <value>/home/${user.name}/hadoop_tmp_data/tmp</value> --> <!-- Alternativa usando user.name -->
        <description>
            Um diretório base para outros diretórios temporários usados pelo Hadoop.
            Por padrão, é /tmp/hadoop-${user.name}.
            É RECOMENDADO definir explicitamente para um local persistente e com espaço
            suficiente, especialmente se /tmp for volátil (ex: limpo em reboots).
            Em um ambiente Docker, este caminho deve corresponder a um volume montado
            se a persistência entre reinicializações do contêiner for desejada.
            Certifique-se que o usuário Hadoop tenha permissão de escrita neste diretório.
        </description>
        <final>false</final> <!-- Permite que seja sobrescrito, se necessário -->
    </property>

    <property>
        <name>io.file.buffer.size</name>
        <value>131072</value> <!-- 128 KB -->
        <description>
            O tamanho do buffer para operações de I/O de sequência de arquivos.
            O padrão é geralmente 65536 (64KB) ou 4096 (4KB) em versões mais antigas.
            Aumentar para 128KB ou 256KB pode melhorar o desempenho de I/O para algumas cargas de trabalho,
            especialmente com arquivos grandes. Teste para encontrar o valor ótimo para seu caso.
        </description>
    </property>

    <!--
    <property>
        <name>hadoop.security.authentication</name>
        <value>simple</value>
        <description>
            Define o modo de autenticação. 'simple' significa sem autenticação forte (Kerberos).
            Para ambientes de desenvolvimento, 'simple' é comum.
            Para produção, Kerberos é recomendado.
        </description>
    </property>

    <property>
        <name>hadoop.security.authorization</name>
        <value>false</value>
        <description>
            Habilita ou desabilita a autorização em nível de serviço.
            Se 'true', requer um arquivo de política (hadoop.policy.file).
            Para desenvolvimento, 'false' é comum.
        </description>
    </property>
    -->

    <!--
        Para comunicação entre componentes em um ambiente de rede restrito ou com múltiplos IPs,
        pode ser útil definir o `hadoop.rpc.protection` ou IPs específicos para RPC.
        No entanto, para um setup Docker simples com uma rede bridge, geralmente não é necessário.
    -->

</configuration>
