import { useState, useEffect } from "react";
import { useAuth } from "./useAuth";

const useGetQuestion = () => {
  const [questions, setQuestions] = useState();
  const { isLogged } = useAuth();

  useEffect(() => {

    if (isLogged) {
      (async () => {
        const response = await fetch("https://tspr.ovh/api/company/questions", {
          method: "POST",
        });

        if (response.ok) {
          const { questions } = await response.json();
          setQuestions(questions);
        }
      }) ();
    }
  }, []);

  return { 
    questions
  };
};

export default useGetQuestion;
