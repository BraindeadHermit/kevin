import { useEffect, useState } from "react";
import { useAuth } from "./useAuth";

const useTelematry = () => {
  const { isLogged } = useAuth();
  const [data, setData] = useState();

  useEffect(() => {
    if (isLogged) {
      getTelemetry();
    }
  }, [isLogged]);

  useEffect(() => {}, [data]);

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
    data.forEach((element) => {
      if (element["QID"] == qid) {
        total += 1;
      }
    });

    return total;
  };

  const getTrueResponseQuestions = (qid) => {
    var total = 0;
    data.forEach((element) => {
      if (element["QID"] == qid && element["Options"][0]) {
        total += 1;
      }
    });

    return total;
  };

  const getFalseResponseQuestions = (qid) => {
    var total = 0;
    data.forEach((element) => {
      if (element["QID"] == qid && !element["Options"][0]) {
        total += 1;
      }
    });

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
