import { useState } from "react";

const useDeleteQuestion = () => {
    const [isDeleted, setIsDeleted] = useState(false)
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

    return { 
        isDeleted,
        deleteQuestion 
    }
}

export default useDeleteQuestion