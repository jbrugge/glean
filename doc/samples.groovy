import groovy.xml.*

class SampleDataTable {
    def sampleToolMap = [:]
    def sampleNameMap = [:]
    def sampleUrlMap = [:]
    
    def toolList = []
    def defaultTools = []

    def propertyDirName
    def toolDirName
    def defaultPropsFile
    
    def propertyFilter = { fileName -> 
        if (fileName.indexOf(".properties") > 0) {
            return true
        } else {
            return false
        }
    }
    
    def loadDefaultTools() {
        def defaultFile = new File(defaultPropsFile)
        def defaultProps = new Properties();
        defaultProps.load(defaultFile.newInputStream())
        
        defaultTools = defaultProps.getProperty("tool.pattern").tokenize(",")
    }
    
    def loadToolList() {
        // Create a list of the tools we have
        def toolDir = new File(toolDirName)

        toolDir.eachFile( { dir ->
            if (dir.getName().indexOf(".svn") == -1) {
                toolList.add(dir.getName())
            }
        })
    }

    def processFiles() {
        loadDefaultTools()
        loadToolList()
        
        // Map the set of tools to their project
        def propertyDir = new File(propertyDirName)

        propertyDir.eachFileMatch(propertyFilter, { file ->
            def projectProps = new Properties()
            projectProps.load(file.newInputStream())
            
            def fileShortName = file.getName()
            
            def tools = projectProps.getProperty("tool.pattern")
            
            if (tools == null) {
                println "No tools defined for " + file + ", using default"
                sampleToolMap[fileShortName] = defaultTools
            } else {
                sampleToolMap[fileShortName] = tools.tokenize(",")
            }
            
            // Also look for the collector tools
            tools = projectProps.getProperty("collector.pattern")
            if (tools != null) {
                sampleToolMap[fileShortName] += tools.tokenize(",")
            }

            def url = projectProps.getProperty("project.url")
            if (url == null) {
                println "No url defined for " + file + ", using default"
                url = "."
            }
            sampleUrlMap[fileShortName] = url

            def name = projectProps.getProperty("src.project.name")
            if (name == null) {
                println "No custom name defined for " + file + ", using file name"
                name = fileShortName.tokenize(".").getAt(0)
            }
            sampleNameMap[fileShortName] = name
        })
    }
    
    def getColumnHeaders() {
        sampleToolMap.collect({ it.key })
    }
    
    def getTableHtml() {
        def writer = new StringWriter()
        def builder = new MarkupBuilder(writer)
        
        def sortedSamples = getColumnHeaders().sort()
        
        builder.table(class:"bodyTable") {
                th(align:"center", "Tool")
            sortedSamples.each( { file ->
                th(align:"center") {
                    a(href:sampleUrlMap[file], sampleNameMap[file])
                }
            })
            toolList.sort().each( { tool ->
                tr() {
                    td(tool)
                    sortedSamples.each( { file ->
                        def sampleTools = sampleToolMap[file]
                        if (sampleTools.contains(tool)) {
                            td(align:"center", "x")
                        } else {
                            td(align:"center")
                        }
                    })
                }
            })
        }
        return writer.toString()
    }
}

// TODO: Turn these two selections in to command-line options
gleanHome = "/Users/john/work/glean/src"
outFileName = gleanHome + "/../doc/src/stylesheet/samples-table.html"

sampleTable = new SampleDataTable()
sampleTable.propertyDirName = gleanHome + "/sample"
sampleTable.toolDirName = gleanHome + "/tool"
sampleTable.defaultPropsFile = gleanHome + "/feedback.properties"
sampleTable.processFiles()

rowsHtml = sampleTable.getTableHtml()

outFile = new File(outFileName)
outFile.write(rowsHtml)
