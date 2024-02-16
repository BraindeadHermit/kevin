import { Bar } from 'react-chartjs-2'
import { Chart as ChartJS } from 'chart.js/auto'
import { useState } from 'react';

export default function BarChart() {

    return <Bar data={{
        labels: ['livello 1', 'livello 2'],
        datasets: [{
            maxBarThickness: 50,
            borderRadius: 8,
            axis: 'y',
            label: 'Risposte esatte',
            data: [65, 59],
            fill: true, 
            backgroundColor: ['green'],
            borderWidth: 0,
        },
        {
            maxBarThickness: 50,
            borderRadius: 8,
            axis: 'y',
            label: 'Risposte errate',
            data: [34, 22],
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
  