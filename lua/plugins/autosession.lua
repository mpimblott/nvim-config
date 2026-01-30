return {
	"rmagatti/auto-session",
	lazy = false,

	---enables autocomplete for opts
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
        auto_restore_last_session= true,
        session_lens= {
            picker = "telescope"
        }
	},
}
