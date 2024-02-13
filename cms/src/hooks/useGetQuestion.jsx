import { useState, useEffect } from "react";
import useDeleteQuestion from "./useDeleteQuestion";

const useGetQuestion = () => {
    const [questions, setQuestions] = useState(null);
    const { isDeleted } = useDeleteQuestion();

    useEffect(() => {
        const getQuestion = async () => {
            try {
                const response = await fetch('api/company/questions', {
                    method: 'POST'
                });

                if (!response.ok) {
                    throw new Error(`${response.status}`);
                }

                const data = await response.json();
                setQuestions(data);
            } catch (error) {
                console.error("Error fetching questions:", error);
            }
        };

        getQuestion();
    }, []);
    
    return { questions };
};

export default useGetQuestion;