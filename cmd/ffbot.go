/*
Copyright © 2023 NAME HERE <EMAIL ADDRESS>
*/
package cmd

import (
	"fmt"
	"log"
	"os"
	"time"

	"github.com/spf13/cobra"

	telebot "gopkg.in/telebot.v3"
)

var (
	teleToken = os.Getenv("TELE_TOKEN")
)

// ffbotCmd represents the ffbot command
var ffbotCmd = &cobra.Command{
	Use:     "ffbot",
	Aliases: []string{"start"},
	Short:   "A brief description of your command",
	Long: `A longer description that spans multiple lines and likely contains examples
and usage of using your command. For example:

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.`,
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Printf("fbot %s started", appVersion)

		ffbot, err := telebot.NewBot(telebot.Settings{
			URL:    "",
			Token:  teleToken,
			Poller: &telebot.LongPoller{Timeout: 10 * time.Second},
		})

		if err != nil {
			log.Fatalf("Please check TELE_TOKEN variable. %s", err)
			return
		}

		ffbot.Handle(telebot.OnText, func(m telebot.Context) error {

			log.Print(m.Message().Payload, m.Text())

			payload := m.Message().Payload

			switch payload {
			case "hello":
				err = m.Send(fmt.Sprintf("Hello, i'm FFbot %s!", appVersion))

			}

			return err
		})

		ffbot.Start()
	},
}

func init() {
	rootCmd.AddCommand(ffbotCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// ffbotCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// ffbotCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}
