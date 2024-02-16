import { useEffect, useState } from "react";
import { useAuth } from "./useAuth";
import { elements } from "chart.js";

const useTelematry = () => {
  const { isLogged } = useAuth();
  const [data, setData] = useState();

  useEffect(() => {
    if (isLogged) {
      getTelemetry();
    }
  }, [isLogged]);

  const getTelemetry = async () => {
    const response = await fetch("api/company/telemetry", {
      method: "POST",
    });

    if (response.ok) {
      const { telemetry } = await response.json();
      setData(telemetry);
    }
  };

  const getQuestionTotalResponse = (qid) => {
    var total = 0;

    if (data) {
      data.forEach((element) => {
        
        if (element["QID"] == qid) {
          total += 1;
        }
      });
    }

    return total;
  };

  const getTrueResponseQuestions = (qid) => {
    var total = 0;
    
    if (data) {

      data.forEach((element) => {

        if (element["Options"] == []) {
          return 0
        }

        if (element["QID"] == qid && element["Options"][0]) {
          total += 1;
        }
      });
    }

    return total;
  };

  const getFalseResponseQuestions = (qid) => {
    var total = 0;

    if (data) {
      data.forEach((element) => {

        if (element["Options"] == []) {
          return 0
        }

        if (element["QID"] == qid && !element["Options"][0]) {
          total += 1;
        }
      });
    }

    return total;
  };

  return {
    data,
    getQuestionTotalResponse,
    getFalseResponseQuestions,
    getTrueResponseQuestions,
  };
};

export default useTelematry;
