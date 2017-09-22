function registrarQtdAlimentos(Alimento_Id, sender) {
    var btn = $(sender);
    // Busca quantidade digitada
    var Qtd = $('.qtd[data-alimento-id="' + Alimento_Id + '"]');
    // Envia para model
    $.ajax({
        method: 'POST',
        url: '/Alimentos/RegistrarAlimentoSelecionado',
        data: {
            Quantidade: Qtd.val(),
            Alimento: {
                Id: Alimento_Id
            }
            
        },
        beforeSend: function () {
            btn.html('Adicionando...').attr('disabled', 'disabled');
        },
        success: function () {
            btn.html('Adicionar').removeAttr('disabled');
            alert('Registrado com sucesso!');
        }
    });
}