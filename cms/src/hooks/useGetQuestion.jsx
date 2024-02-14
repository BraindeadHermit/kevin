import { useState, useEffect } from "react";
import useDeleteQuestion from "./useDeleteQuestion";
import { useAuth } from "./useAuth";

const useGetQuestion = () => {
  const [questions, setQuestions] = useState();
  const { isDeleted } = useDeleteQuestion();
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
          console.log(questions);
        }
      })();

      console.log("executed logged");
    }
  }, []);

  return { questions };
};

export default useGetQuestion;
