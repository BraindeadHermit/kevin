import { useState, useEffect } from "react";
import { useAuth } from "./useAuth";

const useGetQuestion = () => {
  const [questions, setQuestions] = useState();
  const [isDeleted, setIsDeleted] = useState(false);
  const [isAdded, setIsAdded] = useState(false);
  const { isLogged } = useAuth();

  useEffect(() => {
    if (isLogged) {
      (async () => {
        const response = await fetch("api/company/questions", {
          method: "POST",
        });

        if (response.ok) {
          const { questions } = await response.json();
          setQuestions(questions);
        }
      })();
    }
  }, []);

  /*useEffect(() => {
    if(isLogged){
      setQuestions(questions)
    }
  }, [questions])*/
    




  return { 
    questions
  };
};

export default useGetQuestion;
