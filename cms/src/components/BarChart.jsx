import { Bar } from 'react-chartjs-2'
import { Chart as ChartJS } from 'chart.js/auto'

export default function BarChart(props) {
    const level1 = props.questions && props.questions.filter(item => { return item.Category === 'malware' });
    const level2 = props.questions && props.questions.filter(item => { return item.Category === 'DDOS' });

    console.log(level1, level2);

    const trueQuestionsLv1 = () => {
        var total = 0;

        level1 && level1.forEach(element => {
            total += props.trueQuestions(element.QID)
        });

        return total;
    }

    const falseQuestionLv1 = () => {
        var total = 0;

        level1 && level1.forEach(element => {
            total += props.falseQuestions(element.QID)
        })

        return total;
    }

    const trueQuestionsLv2 = () => {
        var total = 0;

        level2 && level2.forEach(element => {
            total += props.trueQuestions(element.QID)
        });

        return total;
    }

    const falseQuestionLv2 = () => {
        var total = 0;

        level2 && level2.forEach(element => {
            total += props.falseQuestions(element.QID)
        })

        return total;
    }

    return <Bar data={{
        labels: ['livello 1', 'livello 2'],
        datasets: [{
            maxBarThickness: 50,
            borderRadius: 8,
            axis: 'y',
            label: 'Risposte esatte',
            data: [trueQuestionsLv1(), falseQuestionLv1()],
            fill: true, 
            backgroundColor: ['green'],
            borderWidth: 0,
        },
        {
            maxBarThickness: 50,
            borderRadius: 8,
            axis: 'y',
            label: 'Risposte errate',
            data: [trueQuestionsLv2(), falseQuestionLv2()],
            fill: true, 
            backgroundColor: ['red'],
            borderWidth: 0,
        },
    ]
    }} 
    options={{
        responsive: true,
        scales: {
            y: {
                ticks: {
                    font: {
                        size: 18,
                        weight: '500'
                    }
                }
            },
            x: {
                ticks: {
                    font: {
                        size: 16
                    }
                }
            }
        },
        plugins: {
            legend: {
                labels: {
                    font: {
                        size: 16
                    }
                }
            }
        },
        indexAxis: 'y',
        }}/>
} 
  
