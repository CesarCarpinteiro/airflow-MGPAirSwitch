# Etapa 1: Importando módulos 
# Para iniciar o objeto DAG 
from airflow import DAG 
# Importando os módulos datetime e timedelta para agendar os DAGs 
from datetime import timedelta, datetime, date 
import datetime
# Importando operadores 
from airflow.operators.dummy_operator import DummyOperator 
from airflow.providers.docker.operators.docker import DockerOperator

today = date.today()
today_day = today.day - 1 if today.day > 1 else today.day

# Etapa 2: Iniciando o default_args 
default_args = {
    'owner': 'airflow',
    'start_date': datetime.datetime(today.year,month=today.month,day=today_day),
    'retries': 3,
    'retry_delay': datetime.timedelta(minutes=1)
}

# Etapa 3: Criando o objeto DAG 
dag = DAG(
        dag_id='mgp-airflow1', 
        default_args=default_args, 
        schedule_interval="0 9 * * *", 
        catchup=False 
    ) 

# Etapa 4: Criando a tarefa 
# Criando a primeira tarefa 
start = DummyOperator(task_id = 'start', dag = dag) 
# Criando a segunda tarefa 
end = DummyOperator(task_id = 'end', dag = dag) 

t2 = DockerOperator(
        task_id='docker_command_hello',
        image='python:3.8-slim',
        container_name='task___command_hello',
        api_version='auto',
        auto_remove=True,
        command="echo hello",
        docker_url="unix://var/run/docker.sock",
        network_mode="bridge"
        )

# Etapa 5: Configurando dependências 
start >> t2 >> end 