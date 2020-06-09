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
            const qContent = document.getElementById("quotation_content").value

            console.log(`${qType}: ${qContent}`)
            channel.push("shout", {name: qType, body: qContent})

            document.getElementById("quotation_type").value = ""
            document.getElementById("quotation_content").value = ""
        })

        channel.on("shout", payload => {
            const chatBox = document.querySelector("#chat-box")
            const msgBlock = document.createElement("p")

            msgBlock.insertAdjacentHTML("beforeend", `<b>${payload.name}:</b> ${payload.body}`)
            chatBox.prepend(msgBlock)
        })
    }
}

export default Quotation
