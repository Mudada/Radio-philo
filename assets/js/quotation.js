const htmlQuotation = (payload) => `
            <div class="message-header">
                <b>${payload.userName} | ${payload.label} :</b>
            </div>
            <div class="message-body">
                <p>
                    ${payload.body}
                </p>
            </div>`

const QTypeMap = new Map([["citation", "is-dark"], ["viewer", "is-info"]])

const Quotation = {

    init(socket) {
        const channel = socket.channel("quotation:lobby", {})
        channel.join()
        this.listenForChats(channel)
    },

    listenForChats(channel){
        document.getElementById("chat-form").addEventListener("submit", (e) => {
            e.preventDefault()

            const qType = document.getElementById("quotation_type").value
            const userName = document.getElementById("userName").value
            const qContent = document.getElementById("quotation_content").value

            console.log(`${userName}: ${qType}: ${qContent}`)
            channel.push("shout", {userName: userName, body: qContent, label: qType})

            document.getElementById("quotation_type").value = qType
            document.getElementById("quotation_content").value = ""
        })

        channel.on("shout", payload => {
            const chatBox = document.querySelector("#chat-box")
            const msgBlock = document.createElement("article")
            msgBlock.setAttribute('class', 'message ' + QTypeMap.get(payload.name));


            msgBlock.insertAdjacentHTML("beforeend", htmlQuotation(payload))
            chatBox.prepend(msgBlock)
        })
    }
}

export default Quotation
