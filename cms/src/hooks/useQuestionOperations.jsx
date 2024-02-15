const useQuestionsOperations = () => {
const deleteQuestion = async (url, qid) => {  
    try {
        const response = await fetch(url, {
            method: 'POST',
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify(qid)
        })

        if (!response.ok)
            throw new Error(`${response.status}`);

        setIsDeleted(true);
    } catch (error) {
        console.error("Error fetching questions:", error);
    } 
}

const insert = async (url, data) => {
  try {
      console.log(data)
      const response = await fetch(url, {
          method: 'POST',
          headers: {
              "Content-Type": "application/json",
          },
          body: JSON.stringify(data)
      })

      if (!response.ok)
          throw new Error(`${response.status}`);

      setIsAdded(true);
  } catch (error) {
      console.error("Error fetching questions:", error);
  } 

}
return {
    deleteQuestion,
    insert
  }
}

export default useQuestionsOperations;