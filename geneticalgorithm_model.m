close
CM = [76 81 71;242 70 67;255 219 76;19 118 160;234 235 237];
fig = figure('Name','Modélisation de la population',...
             'Numbertitle','off',...
             'ToolBar','none',...
             'WindowState','maximized',...
             'Color',[1 1 1]);
%            'Color',CM(5,:)/255);
colormap(CM/255);
Length = 1;
Size = 2;

Ver = [1 1;2 1;1 2;2 2];
Fac = [1 2 4 3];
CInd = 1;

VerE = [1 1;2 1;1 2;2 2];
FacE = [1 2 4 3];
CIndE = 1;

axis('off','equal',[0 1.5*(Size+1) 0 Length+2]);
ax = gca;

CLK = char(datetime('now','Format',' yyyy-MM-dd HH-mm'));
vid = VideoWriter(['vid',CLK,'.mp4'],'MPEG-4');
open(vid)

Logic = logical(randi([0 1],Size,Length));
PopulAnim = gobjects(Size,Length);
Tio = gobjects(Size,Length);
for x = 1:Size
    VerE(:,1) = Ver(1:4,1) + 1.5*(x-1);
    for y = 1:Length
        VerE(:,2) = Ver(1:4,2) + (y-1);
        CIndE = 4-Logic(x,y);
        
        GenomAnim = patch('Faces',FacE,...
                          'Vertices',VerE,...
                          'FaceVertexCData',CIndE,...
                          'FaceColor','flat',...
                          'CDataMapping','direct',...
                          'LineWidth',2,...
                          'EdgeColor',CM(1,:)/255);
        PopulAnim(x,y) = GenomAnim;
        
        Tio(x,y) = text((1.5*x),(y+0.5),'O',...
                        'Color',CM(1,:)/255,...
                        'HorizontalAlignment','center',...
                        'FontName','Cambria',...
                        'FontWeight','bold',...
                        'FontSize',25);
        if Logic(x,y)
            Tio(x,y).String = 'I';
        end
        
        if x==1
            img = print('-RGBImage');
            writeVideo(vid,repmat(img,1,1,1,4));
        end
    end
    if x~=1
        img = print('-RGBImage');
        writeVideo(vid,repmat(img,1,1,1,4));
    end
end

frame = print('-RGBImage');
imwrite(frame,'Test_ga.png');
