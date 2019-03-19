pipeline {
    agent any
    stages {
        stage('Clone repo'){
            steps {
            git url:'https://github.com/szwedek/system_stats.git'
            }
        }

        stage('Run docker-compose up'){
            steps{
                sh 'docker-compose rm -f'
                sh 'docker-compose up -d --build'
                sh 'sleep 10'
            }
        }
        
        stage('Run deploy'){
            environment {
                POSTGRES_USER="postgres"
                POSTGRES_PASSWORD="password"
                POSTGRES_DB="db"
            }
            steps{
                sh 'ADD_COL=$(cat updates/add_ip_field.sql | docker exec -i system_stats_db_1 /bin/bash -c "export PGPASSWORD=${POSTGRES_PASSWORD} && psql -U ${POSTGRES_USER} ${POSTGRES_DB}"); if [ "$ADD_COL" == "ALTER TABLE" ]; then echo "ADD COL SUCCESS"; exit 0; else echo "ADD COL FAILED"; exit 1; fi'
                sh 'cp updates/writer.py mservices/writer.py'
                sh 'docker-compose up -d --scale writer=2 --no-recreate'
                sh 'docker restart system_stats_writer_1'
                sh 'docker-compose up -d --scale writer=1 --no-recreate'
            }
        }
        
        stage('Testing'){
            steps{
                sh 'RESP_TEST=$(curl -m 5 -s --header "Content-Type: application/json" --request POST --data \'{"type":"test","payload":"test"}\'   http://localhost/log); if [ "$RESP_TEST" == "OK" ]; then echo "SUCCESS"; exit 0; else echo "FAILED"; exit 1; fi'
            }
        }
        
    }
    
    post{
        always{
            sh 'docker-compose down'
            sh 'docker volume rm system_stats_db-data'
            cleanWs()
        }
    }
}
