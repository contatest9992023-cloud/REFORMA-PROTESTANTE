# REFORMA-PROTESTANTE
Perguntas sobre a reforma
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz: Reforma Protestante</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');
        body { font-family: 'Inter', sans-serif; }
        .question-card {
            transition: all 0.3s ease;
            transform: translateY(20px);
            opacity: 0;
        }
        .question-card.active {
            transform: translateY(0);
            opacity: 1;
        }
        .option-btn {
            transition: all 0.2s ease;
        }
        .option-btn:hover {
            transform: translateX(4px);
        }
        .correct {
            background: linear-gradient(135deg, #10b981, #059669);
            color: white;
        }
        .incorrect {
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: white;
        }
        .progress-bar {
            transition: width 0.5s ease;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-blue-900 via-purple-900 to-indigo-900 min-h-screen">
    <div class="container mx-auto px-4 py-8 max-w-4xl">
        <!-- Header -->
        <div class="text-center mb-8">
            <h1 class="text-4xl font-bold text-white mb-2">📜 Quiz: Reforma Protestante</h1>
            <p class="text-blue-200 text-lg">Teste seus conhecimentos sobre este marco histórico</p>
        </div>

        <!-- Progress Bar -->
        <div class="bg-white/20 rounded-full h-3 mb-8 overflow-hidden">
            <div id="progressBar" class="progress-bar bg-gradient-to-r from-green-400 to-blue-500 h-full rounded-full" style="width: 0%"></div>
        </div>

        <!-- Question Counter -->
        <div class="text-center mb-6">
            <span id="questionCounter" class="text-white text-lg font-medium">Questão 1 de 15</span>
        </div>

        <!-- Quiz Container -->
        <div id="quizContainer" class="question-card active bg-white/95 backdrop-blur-sm rounded-2xl shadow-2xl p-8">
            <!-- Questions will be inserted here -->
        </div>

        <!-- Results Screen -->
        <div id="resultsScreen" class="hidden bg-white/95 backdrop-blur-sm rounded-2xl shadow-2xl p-8 text-center">
            <div class="mb-6">
                <div id="scoreIcon" class="text-6xl mb-4"></div>
                <h2 class="text-3xl font-bold text-gray-800 mb-2">Quiz Concluído!</h2>
                <p id="finalScore" class="text-xl text-gray-600 mb-4"></p>
                <p id="scoreMessage" class="text-lg text-gray-700 mb-6"></p>
            </div>
            
            <div class="grid md:grid-cols-2 gap-4 mb-6">
                <div class="bg-green-100 p-4 rounded-lg">
                    <div class="text-2xl font-bold text-green-600" id="correctCount">0</div>
                    <div class="text-green-700">Acertos</div>
                </div>
                <div class="bg-red-100 p-4 rounded-lg">
                    <div class="text-2xl font-bold text-red-600" id="incorrectCount">0</div>
                    <div class="text-red-700">Erros</div>
                </div>
            </div>

            <button onclick="restartQuiz()" class="bg-gradient-to-r from-blue-600 to-purple-600 text-white px-8 py-3 rounded-lg font-semibold hover:from-blue-700 hover:to-purple-700 transition-all duration-200 transform hover:scale-105">
                🔄 Refazer Quiz
            </button>
        </div>
    </div>

    <script>
        const questions = [
            {
                question: "Em que ano Martinho Lutero publicou suas 95 teses?",
                options: ["1500", "1517", "1525", "1534"],
                correct: 1,
                correctExplanation: "Martinho Lutero publicou suas 95 teses em 31 de outubro de 1517, na porta da Igreja do Castelo de Wittenberg. Este evento marca o início da Reforma Protestante, quando Lutero questionou publicamente as práticas da Igreja Católica, especialmente a venda de indulgências.",
                wrongExplanations: [
                    "1500 é muito cedo - Lutero ainda estava estudando e não havia desenvolvido suas críticas à Igreja.",
                    null, // Esta é a resposta correta
                    "1525 é posterior às 95 teses - neste ano ocorreu a Guerra dos Camponeses.",
                    "1534 é muito tardio - neste ano Henrique VIII rompeu com Roma, mas as teses de Lutero são de 1517."
                ]
            },
            {
                question: "Qual foi o principal motivo que levou Lutero a escrever as 95 teses?",
                options: ["Criação do calvinismo", "Aliança com o Papa", "Venda de indulgências", "Separação da Inglaterra da Igreja"],
                correct: 2,
                correctExplanation: "Lutero escreveu as 95 teses principalmente para contestar a venda de indulgências pela Igreja Católica. Ele criticava a prática de vender perdão dos pecados, argumentando que a salvação não poderia ser comprada, mas sim obtida pela fé e graça divina.",
                wrongExplanations: [
                    "O calvinismo foi criado por João Calvino, não por Lutero, e é posterior às 95 teses.",
                    "Lutero não buscava aliança com o Papa - pelo contrário, criticava suas práticas.",
                    null, // Esta é a resposta correta
                    "A separação da Inglaterra ocorreu com Henrique VIII em 1534, não foi motivo das teses de Lutero."
                ]
            },
            {
                question: "Qual destes princípios não faz parte dos \"Cinco Solas\" da Reforma?",
                options: ["Sola Scriptura", "Sola Fide", "Sola Ecclesia", "Solus Christus"],
                correct: 2,
                correctExplanation: "Os Cinco Solas são: Sola Scriptura (somente a Escritura), Sola Fide (somente a fé), Sola Gratia (somente a graça), Solus Christus (somente Cristo) e Soli Deo Gloria (glória somente a Deus). 'Sola Ecclesia' não existe, pois os reformadores rejeitavam a autoridade exclusiva da Igreja.",
                wrongExplanations: [
                    "Sola Scriptura (somente a Escritura) é um dos cinco princípios fundamentais da Reforma.",
                    "Sola Fide (somente a fé) é um dos cinco princípios fundamentais da Reforma.",
                    null, // Esta é a resposta correta
                    "Solus Christus (somente Cristo) é um dos cinco princípios fundamentais da Reforma."
                ]
            },
            {
                question: "Quem liderou a Reforma Protestante na cidade de Genebra?",
                options: ["Martinho Lutero", "João Calvino", "Erasmo de Roterdã", "Ulrico Zuínglio"],
                correct: 1,
                correctExplanation: "João Calvino liderou a Reforma em Genebra, Suíça, a partir de 1541. Ele estabeleceu uma teocracia protestante na cidade e desenvolveu a teologia calvinista, incluindo a doutrina da predestinação. Genebra tornou-se um centro importante da Reforma Protestante.",
                wrongExplanations: [
                    "Martinho Lutero liderou a Reforma na Alemanha, não em Genebra.",
                    null, // Esta é a resposta correta
                    "Erasmo de Roterdã foi um humanista que influenciou a Reforma, mas não liderou em Genebra.",
                    "Ulrico Zuínglio liderou a Reforma em Zurique, não em Genebra."
                ]
            },
            {
                question: "Qual país foi o berço do movimento liderado por Martinho Lutero?",
                options: ["França", "Inglaterra", "Alemanha", "Suíça"],
                correct: 2,
                correctExplanation: "A Alemanha foi o berço da Reforma Protestante liderada por Martinho Lutero. Foi em Wittenberg, no Sacro Império Romano-Germânico (atual Alemanha), que Lutero publicou suas 95 teses e iniciou o movimento reformista que se espalhou por toda a Europa.",
                wrongExplanations: [
                    "A França teve reformadores como Calvino, mas não foi o berço do movimento luterano.",
                    "A Inglaterra teve sua própria reforma com Henrique VIII, mas não foi onde Lutero iniciou o movimento.",
                    null, // Esta é a resposta correta
                    "A Suíça foi importante para a Reforma com Calvino e Zuínglio, mas não foi onde Lutero começou."
                ]
            },
            {
                question: "O que significa \"Sola Fide\", princípio da Reforma?",
                options: ["Salvação pela Igreja", "Salvação pela fé", "Fé nos santos", "Fé e boas obras"],
                correct: 1,
                correctExplanation: "Sola Fide significa 'somente pela fé' e é um dos princípios centrais da Reforma. Os reformadores ensinavam que a salvação é obtida somente pela fé em Jesus Cristo, não pelas boas obras ou pela mediação da Igreja, contrariando a doutrina católica da época.",
                wrongExplanations: [
                    "Os reformadores rejeitavam a ideia de salvação pela Igreja - defendiam acesso direto a Deus.",
                    null, // Esta é a resposta correta
                    "A fé nos santos era uma prática católica rejeitada pelos reformadores.",
                    "Os reformadores enfatizavam que a salvação é pela fé, não pelas obras."
                ]
            },
            {
                question: "Qual desses eventos está ligado à repressão dos camponeses durante a Reforma?",
                options: ["Guerra dos Camponeses (1524–1525)", "Paz de Augsburgo", "Concílio de Trento", "Edito de Nantes"],
                correct: 0,
                correctExplanation: "A Guerra dos Camponeses (1524-1525) foi uma revolta de camponeses alemães que interpretaram as ideias de Lutero como apoio à justiça social. Lutero, porém, condenou a revolta e apoiou a repressão violenta pelos príncipes, resultando na morte de cerca de 100.000 camponeses.",
                wrongExplanations: [
                    null, // Esta é a resposta correta
                    "A Paz de Augsburgo (1555) foi um acordo que permitiu aos príncipes escolher a religião de seus territórios.",
                    "O Concílio de Trento foi a resposta católica à Reforma, não relacionado à repressão camponesa.",
                    "O Edito de Nantes (1598) concedeu tolerância religiosa aos huguenotes na França."
                ]
            },
            {
                question: "O que Martinho Lutero defendeu em relação à Bíblia?",
                options: ["Que só os padres podiam lê-la", "Que fosse mantida em latim", "Que fosse traduzida para o vernáculo", "Que fosse abolida do culto"],
                correct: 2,
                correctExplanation: "Lutero defendia que a Bíblia deveria ser traduzida para o vernáculo (língua do povo) para que todos pudessem lê-la e compreendê-la. Ele mesmo traduziu a Bíblia para o alemão, democratizando o acesso às Escrituras e reduzindo a dependência do clero para interpretação.",
                wrongExplanations: [
                    "Lutero defendia o contrário - que todos deveriam poder ler a Bíblia, não apenas padres.",
                    "Lutero criticava o uso exclusivo do latim, defendendo traduções para línguas populares.",
                    null, // Esta é a resposta correta
                    "Lutero valorizava muito a Bíblia e defendia seu uso central no culto."
                ]
            },
            {
                question: "Qual foi a principal consequência religiosa da Reforma?",
                options: ["Reunificação da cristandade", "Fragmentação do cristianismo ocidental", "Fortalecimento da autoridade papal", "Proibição da Bíblia"],
                correct: 1,
                correctExplanation: "A principal consequência da Reforma foi a fragmentação do cristianismo ocidental. A unidade religiosa medieval sob a Igreja Católica foi quebrada, surgindo diversas denominações protestantes (luteranos, calvinistas, anglicanos, etc.), criando um pluralismo religioso na Europa.",
                wrongExplanations: [
                    "A Reforma causou divisão, não reunificação - criou múltiplas denominações cristãs.",
                    null, // Esta é a resposta correta
                    "A Reforma enfraqueceu a autoridade papal, não a fortaleceu.",
                    "A Reforma promoveu a leitura da Bíblia, não sua proibição."
                ]
            },
            {
                question: "Qual rei rompeu com o Papa e criou a Igreja Anglicana?",
                options: ["Carlos V", "Francisco I", "Henrique VIII", "Luís XIV"],
                correct: 2,
                correctExplanation: "Henrique VIII da Inglaterra rompeu com o Papa em 1534 e criou a Igreja Anglicana através do Ato de Supremacia. O motivo principal foi o Papa ter negado a anulação de seu casamento com Catarina de Aragão. Henrique se tornou o chefe supremo da Igreja na Inglaterra.",
                wrongExplanations: [
                    "Carlos V foi Imperador do Sacro Império e defendeu o catolicismo contra a Reforma.",
                    "Francisco I foi rei da França e permaneceu católico, embora tenha se aliado a protestantes politicamente.",
                    null, // Esta é a resposta correta
                    "Luís XIV foi rei da França no século XVII e perseguiu os protestantes franceses."
                ]
            },
            {
                question: "O que foi o Concílio de Trento (1545–1563)?",
                options: ["Um tribunal de inquisição protestante", "A resposta da Igreja Católica à Reforma", "A reunião dos reformadores", "A fundação da igreja calvinista"],
                correct: 1,
                correctExplanation: "O Concílio de Trento foi a resposta oficial da Igreja Católica à Reforma Protestante, iniciando a Contrarreforma. O concílio reafirmou doutrinas católicas, reformou práticas internas da Igreja, estabeleceu seminários para formação do clero e definiu o cânon bíblico católico.",
                wrongExplanations: [
                    "Não existiu tribunal de inquisição protestante - a Inquisição era católica.",
                    null, // Esta é a resposta correta
                    "Foi uma reunião de líderes católicos, não de reformadores protestantes.",
                    "A igreja calvinista foi fundada por João Calvino, não pelo Concílio de Trento."
                ]
            },
            {
                question: "Qual invenção tecnológica favoreceu a propagação das ideias reformistas?",
                options: ["Rádio", "Telégrafo", "Imprensa de tipos móveis", "Calculadora"],
                correct: 2,
                correctExplanation: "A imprensa de tipos móveis, inventada por Gutenberg por volta de 1440, foi fundamental para a Reforma. Permitiu a impressão rápida e barata de livros, panfletos e traduções da Bíblia, facilitando a disseminação das ideias reformistas por toda a Europa de forma sem precedentes.",
                wrongExplanations: [
                    "O rádio foi inventado no século XIX, muito posterior à Reforma Protestante do século XVI.",
                    "O telégrafo foi inventado no século XIX, muito posterior à Reforma Protestante.",
                    null, // Esta é a resposta correta
                    "A calculadora não tem relação com a propagação de ideias religiosas da Reforma."
                ]
            },
            {
                question: "Quem eram os anabatistas?",
                options: ["Padres que apoiavam Lutero", "Grupo radical que defendia o batismo apenas em adultos", "Seguidores de Henrique VIII", "Calvinistas da França"],
                correct: 1,
                correctExplanation: "Os anabatistas eram um grupo radical da Reforma que defendia o batismo apenas de adultos conscientes de sua fé (rebatismo). Rejeitavam o batismo infantil e defendiam a separação total entre Igreja e Estado. Foram perseguidos tanto por católicos quanto por outros protestantes.",
                wrongExplanations: [
                    "Os anabatistas eram leigos, não padres, e tinham diferenças significativas com Lutero.",
                    null, // Esta é a resposta correta
                    "Os anabatistas eram um movimento continental europeu, não especificamente inglês.",
                    "Os anabatistas eram distintos dos calvinistas, embora ambos fossem protestantes."
                ]
            },
            {
                question: "Como Lutero reagiu à Guerra dos Camponeses?",
                options: ["Apoiou integralmente", "Manteve-se neutro", "Condenou e pediu repressão violenta", "Fugiu da Alemanha"],
                correct: 2,
                correctExplanation: "Lutero condenou duramente a Guerra dos Camponeses e pediu aos príncipes que reprimissem violentamente a revolta. Em seu panfleto 'Contra as Hordas Assassinas e Ladras dos Camponeses', ele argumentou que a rebelião era contra a ordem divina e deveria ser esmagada.",
                wrongExplanations: [
                    "Lutero não apoiou a revolta - pelo contrário, a condenou veementemente.",
                    "Lutero não se manteve neutro - tomou posição clara contra os camponeses.",
                    null, // Esta é a resposta correta
                    "Lutero permaneceu na Alemanha e continuou suas atividades reformistas."
                ]
            },
            {
                question: "Qual das alternativas abaixo é um legado da Reforma para a sociedade atual?",
                options: ["Proibição da leitura da Bíblia", "Reforço da autoridade papal", "Incentivo à liberdade religiosa e educação", "Redução da alfabetização"],
                correct: 2,
                correctExplanation: "A Reforma deixou importantes legados: incentivou a liberdade religiosa e de consciência, promoveu a educação (para que todos pudessem ler a Bíblia), estimulou a alfabetização, contribuiu para o desenvolvimento do individualismo moderno e influenciou ideias sobre democracia e direitos humanos.",
                wrongExplanations: [
                    "A Reforma promoveu a leitura da Bíblia por todos, não sua proibição.",
                    "A Reforma enfraqueceu a autoridade papal, não a reforçou.",
                    null, // Esta é a resposta correta
                    "A Reforma aumentou a alfabetização ao promover a leitura da Bíblia."
                ]
            }
        ];

        let currentQuestion = 0;
        let score = 0;
        let answered = false;

        function displayQuestion() {
            const container = document.getElementById('quizContainer');
            const question = questions[currentQuestion];
            
            container.innerHTML = `
                <div class="mb-6">
                    <h3 class="text-2xl font-bold text-gray-800 mb-6 leading-relaxed">${question.question}</h3>
                    <div class="space-y-3">
                        ${question.options.map((option, index) => `
                            <button onclick="selectAnswer(${index})" class="option-btn w-full text-left p-4 bg-gray-50 hover:bg-blue-50 border-2 border-gray-200 hover:border-blue-300 rounded-lg transition-all duration-200 font-medium text-gray-700">
                                <span class="inline-block w-8 h-8 bg-blue-100 text-blue-600 rounded-full text-center leading-8 mr-3 font-semibold">${String.fromCharCode(65 + index)}</span>
                                ${option}
                            </button>
                        `).join('')}
                    </div>
                    <div id="explanationArea" class="hidden mt-6">
                        <div id="correctExplanation" class="hidden p-4 bg-green-50 border-l-4 border-green-400 rounded-r-lg mb-4">
                            <div class="flex item
