# CornerRadius v.1.0
# Example:

var body: some View {
        HStack(spacing: 0) {
            Color(.red)
                .frame(width: 100, height: 100)
                .cornerRadius([.topL(20), .topR(50), .bottomL(50)])
            Color(.green)
                .frame(width: 100, height: 100)
                .cornerRadius([.topL(50), .topR(20), .bottomR(50)])
        }
}
