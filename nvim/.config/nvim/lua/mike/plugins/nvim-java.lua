return {
	"nvim-java/nvim-java",
    event = { "BufReadPre", "BufNewFile" },
	ft = "java",
	dependencies = {

		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					jdtls = {
						settings = {
							java = {
								configuration = {
									runtimes = {
										{
											name = "JavaSE-21",
											path = "~/.sdkman/candidates/java/current",
										},
									},
								},
							},
						},
					},
				},

				setup = {
					jdtls = function()
						require("java").setup({
							jdk = {
								auto_install = false,
							},
							root_markers = {
								"settings.gradle",
								"settings.gradle.kts",
								"pom.xml",
								"build.gradle",
								"mvnw",
								"gradlew",
								"build.gradle",
								"build.gradle.kts",
							},
						})
					end,
				},
			},
		},
	},
}
