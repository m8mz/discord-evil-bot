const { SlashCommandBuilder } = require('discord.js');

module.exports = {
  cooldown: 5,
  data: new SlashCommandBuilder()
    .setName('echo')
    .setDescription('Replies with your input!')
    .addStringOption(option => 
      option.setName('input')
        .setDescription('The input to echo back')),
  async execute(interaction) {
    const input = interaction.options.getString('input') ?? 'No input provided';
    await interaction.reply(`User input is '${input}'.`)
  }
};
