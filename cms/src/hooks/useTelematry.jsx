import { useEffect, useState } from "react";
import { useAuth } from "./useAuth";

const useTelematry = () => {
    const { isLogged } = useAuth();
    const [data, setData] = useState();
    const countAnswerMap = {};

    useEffect(() => {
        if (isLogged) {
          (async () => {
            const response = await fetch("api/company/telemetry", {
              method: "POST",
            });
    
            if (response.ok) {
              const data = await response.json();
            
              console.log(data.telemetry);

              data.telemetry.forEach(telemetry => {
                const qid = telemetry.QID;
                
                let count = data.telemetry.filter((tel) => {
                    return tel.QID === qid;
                  }).length;

                countAnswerMap[qid] = count;
              });

              console.log(countAnswerMap);
              setData(data);
            }
          }) ();
        }
      }, []);
    
      return { data };
    };

export default useTelematry;