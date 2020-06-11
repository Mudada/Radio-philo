const htmlQuotation = (payload) => `
            <div class="message-header">
                <b>${payload.userName} | ${payload.label} </b>
                <button class="delete" aria-label="delete" id="delete-${payload.id}" value=${payload.id}></button>
            </div>
            <div class="message-body">
                <p>
                    ${payload.body}
                </p>
            </div>
`

const QTypeMap = new Map([["citation", "is-dark"],
                          ["viewer", "is-info"],
                          ["misunderstanding", "is-warning"],
                          ["question", "is-primary"]])


const deleteArticle = (elem) => elem.parentElement.parentElement.remove()

const addDeleteButton = (elem, channel) => {
    elem.addEventListener("click", (e) =>{
        console.log(elem.value)
        e.preventDefault()
        channel.push("delete", {id: elem.value})
        deleteArticle(elem)
    })
}

const Quotation = {

    init(socket) {
        const channel = socket.channel("quotation:lobby", {})
        channel.join()
        this.addDeleteButtons(channel)
        this.addElementListener(channel)
        this.deleteElementListener(channel)
        this.listenForChats(channel)
    },

    addDeleteButtons(channel) {
        document.querySelectorAll(".delete").forEach((e) => addDeleteButton(e, channel))
    },

    deleteElementListener(channel) {
        channel.on("delete", payload => {
            console.log("DELETE RECEIVED")
            const deleteButton = document.querySelector(`#delete-${payload.id}`)
            if (deleteButton == null)
                return
            deleteArticle(deleteButton)
        })
    },

    addElementListener(channel) {
        const doc = document.getElementById("chat-form")

        if (doc == null)
            return

        doc.addEventListener("submit", (e) => {
            e.preventDefault()
            const qType = document.getElementById("quotation_type").value
            const userName = document.getElementById("userName").value
            const qContent = document.getElementById("quotation_content").value

            console.log(`${userName}: ${qType}: ${qContent}`)
            channel.push("shout", {userName: userName, body: qContent, label: qType})

            document.getElementById("quotation_type").value = qType
            document.getElementById("quotation_content").value = ""
        })
    },

    listenForChats(channel){
        channel.on("shout", payload => {
            const chatBox = document.querySelector("#chat-box")
            const msgBlock = document.createElement("article")
            console.log("Shout received")
            msgBlock.setAttribute('class', 'message ' + QTypeMap.get(payload.label));


            msgBlock.insertAdjacentHTML("beforeend", htmlQuotation(payload))
            chatBox.prepend(msgBlock)
            addDeleteButton(msgBlock.querySelector(`#delete-${payload.id}`), channel)
        })
    }
}

export default Quotation
